time = squeeze(out.x_ref.Time); % Ensure time is a 1D array
x_ref = squeeze(out.x_ref.Data);
x_m = squeeze(out.x_m.Data);
y_ref = squeeze(out.y_ref.Data);
y_m = squeeze(out.y_m.Data);
figure;
hold on; % Keep multiple plots on the same figure
grid on; % Enable grid for better visualization
axis equal; % Keep aspect ratio to maintain circular shape

plot(x_ref, y_ref, 'b', 'LineWidth', 2); % Plot reference trajectory in blue
plot(x_m, y_m, 'r', 'LineWidth', 2); % Plot real trajectory in red

xlabel('X Position');
ylabel('Y Position');
legend('Reference Trajectory', 'Real Trajectory');

hold off;