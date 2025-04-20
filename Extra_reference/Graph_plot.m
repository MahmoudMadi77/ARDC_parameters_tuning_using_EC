% Load and squeeze data (assumed to be from Simulink output)
time = squeeze(out.x_ref.Time); % Ensure time is a 1D array
x_ref = squeeze(out.x_ref.Data);
x_m = squeeze(out.x_m.Data);
y_ref = squeeze(out.y_ref.Data);
y_m = squeeze(out.y_m.Data);
algorithm = 'abc';

%% Plot Trajectories
figure;
hold on;
grid on;
axis equal;

plot(x_ref, y_ref, 'b', 'LineWidth', 2); % Reference trajectory
plot(x_m, y_m, 'r', 'LineWidth', 2);     % Real/optimized trajectory
xlabel('X Position');
ylabel('Y Position');
legend('Reference Trajectory', 'Real Trajectory');
title('Trajectory Comparison');
hold off;

% Save trajectory plot
saveas(gcf, [algorithm, '_' ,'trajectory_plot.png']);

%% Compute Euclidean Error and Metrics
euclidean_error = sqrt((x_ref - x_m).^2 + (y_ref - y_m).^2);
rmse = sqrt(mean(euclidean_error.^2));
mae = mean(abs(euclidean_error));
mse = mean(euclidean_error.^2);
final_error = euclidean_error(end);
r2 = 1 - sum((euclidean_error).^2) / sum((euclidean_error - mean(euclidean_error)).^2);

% Display metrics in console
fprintf('RMSE: %.4f\n', rmse);
fprintf('MAE: %.4f\n', mae);
fprintf('MSE: %.4f\n', mse);
fprintf('Final Position Error: %.4f\n', final_error);
fprintf('R^2 Score: %.4f\n', r2);

%% Save Metrics to .xlsx
metrics = {
    'Metric', 'Value';
    'RMSE', rmse;
    'MAE', mae;
    'MSE', mse;
    'Final Position Error', final_error;
    'R^2 Score', r2
};
writecell(metrics, [algorithm, '_' ,'trajectory_metrics.xlsx']);

%% Save Error Over Time to .csv
error_table = table(time, euclidean_error);
writetable(error_table, [algorithm, '_' ,'error_over_time.csv']);

%% Plot Error Over Time
figure;
plot(time, euclidean_error, 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Euclidean Error');
title('Tracking Error Over Time');
grid on;

% Save error plot
saveas(gcf, [algorithm, '_' , 'error_over_time_plot.png']);

