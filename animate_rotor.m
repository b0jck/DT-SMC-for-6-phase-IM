%% Rotor Animation

% a,b,c,d,e,f (6-phases) voltage inputs
volts = load("voltages.mat").voltages.Data;

% delta_r rotor position
pos = load("rotor_pos.mat").rotor_pos.Data;

% Extract Time vector
tspan = load("rotor_pos.mat").rotor_pos.Time;

% Direction vector for each phase (0-120-240; 30-150-270)°
dirA = [cosd(90); sind(90)];
dirB = [cosd(210); sind(210)];
dirC = [cosd(330); sind(330)];
dirD = [cosd(120); sind(120)];
dirE = [cosd(240); sind(240)];
dirF = [cosd(0); sind(0)];

%% Animation
figure()
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
ax1 = axes('Position',[0.5 0.4 0.4 0.4]);


trail_va = line('XData', [], 'YData', [], 'Color', '#fc0303', 'LineWidth', 2);    
trail_vb = line('XData', [], 'YData', [], 'Color', '#fcce03', 'LineWidth', 2);
trail_vc = line('XData', [], 'YData', [], 'Color', '#00ba4e', 'LineWidth', 2);
trail_vd = line('XData', [], 'YData', [], 'Color', '#00bfff', 'LineWidth', 2);
trail_ve = line('XData', [], 'YData', [], 'Color', '#75009c', 'LineWidth', 2);
trail_vf = line('XData', [], 'YData', [], 'Color', '#00ffa2', 'LineWidth', 2);

ax2 = axes('Position',[-0.1 0.1 0.7 0.7]);

hold on

% Plot circle to represent rotor
circ = 0:0.1:360;
plot(ax2, 1*cosd(circ), 1*sind(circ), 'LineWidth',2, 'Color','#002d7a')

% Create directional vector for each phase
vA_vector = quiver(0,0,0,0,'off', 'Color', '#fc0303', 'LineWidth', 2, 'MaxHeadSize', 0.5);
vB_vector = quiver(0,0,0,0, 'off','Color', '#fcce03', 'LineWidth', 2, 'MaxHeadSize', 0.5);
vC_vector = quiver(0,0,0,0, 'off','Color', '#00ba4e', 'LineWidth', 2, 'MaxHeadSize', 0.5); 
vD_vector = quiver(0,0,0,0, 'off','Color', '#00bfff', 'LineWidth', 2, 'MaxHeadSize', 0.5);
vE_vector = quiver(0,0,0,0, 'off','Color', '#75009c', 'LineWidth', 2, 'MaxHeadSize', 0.5);
vF_vector = quiver(0,0,0,0, 'off','Color', '#00ffa2', 'LineWidth', 2, 'MaxHeadSize', 0.5);

% Create directional vector for each phase
v_tot_vector = quiver(0,0,0,0, 'off','Color', 'k', 'LineWidth', 4, 'MaxHeadSize', 0.5);

% Create directional vector for rotor angle
v_pos_vector = quiver(0,0,0,0, 'Color', '#a84d9f', 'LineWidth', 2.5, 'MaxHeadSize', 0.5);

t_text = text(1.2,-1.2,num2str(0),...
'VerticalAlignment','top','FontSize',14);

volts = volts./max(volts);
% Start Animation
for i=5000:length(volts)
    axis equal

    % Voltage input at time k
    V = volts(i,:);
    % Phase Voltage: Module*direction
    vA = V(1)*dirA;
    vB = V(3)*dirB;
    vC = V(5)*dirC;
    vD = V(2)*dirD;
    vE = V(4)*dirE;
    vF = V(6)*dirF;

    % Sum components to get total vector
    v_tot = vA + vB + vC + vD + vE + vF;
    v_tot = v_tot/norm(v_tot)

    % Update vector modules
    set(vA_vector, 'XData', 0, 'YData', 0, 'UData', vA(1), 'VData', vA(2));
    set(vB_vector, 'XData', 0, 'YData', 0, 'UData', vB(1), 'VData', vB(2));
    set(vC_vector, 'XData', 0, 'YData', 0, 'UData', vC(1), 'VData', vC(2));
    set(vD_vector, 'XData', 0, 'YData', 0, 'UData', vD(1), 'VData', vD(2));
    set(vE_vector, 'XData', 0, 'YData', 0, 'UData', vE(1), 'VData', vE(2));
    set(vF_vector, 'XData', 0, 'YData', 0, 'UData', vF(1), 'VData', vF(2));
    set(v_tot_vector, 'XData', 0, 'YData', 0, 'UData', v_tot(1), 'VData', v_tot(2));
    set(v_pos_vector, 'XData', 0, 'YData', 0, 'UData', 1.1*cos(pos(i)), 'VData', 1.1*sin(pos(i)) );
    
    set(t_text, 'String', num2str(tspan(i)));

    xlim(ax2,[-1.7, 1.7]);
    ylim(ax2,[-1.7, 1.7]);
    legend('Rotor','v_a','v_b','v_c','v_d','v_e','v_f', 'v_tot','\delta_r')
   
    hold on
    
    % plot(ax1,tspan(i),V(1),'o', 'Color','#fc0303')
    % hold on
    % plot(ax1,tspan(i),V(2),'o', 'Color', '#fcce03')
    % hold on
    % plot(ax1,tspan(i),V(3),'o','Color', '#00ba4e')
    % hold on
    % plot(ax1,tspan(i),V(4),'o','Color', '#00bfff')
    % hold on
    % plot(ax1,tspan(i),V(5),'o','Color', '#75009c')
    % plot(ax1,tspan(i),V(6),'o','Color', '#00ffa2')
    x_trail_va = [get(trail_va, 'XData'), tspan(i)];
    y_trail_va = [get(trail_va, 'YData'), V(1)];

    x_trail_vb = [get(trail_vb, 'XData'), tspan(i)];
    y_trail_vb = [get(trail_vb, 'YData'), V(3)];

    x_trail_vc = [get(trail_vc, 'XData'), tspan(i)];
    y_trail_vc = [get(trail_vc, 'YData'), V(5)];

    x_trail_vd = [get(trail_vd, 'XData'), tspan(i)];
    y_trail_vd = [get(trail_vd, 'YData'), V(2)];

    x_trail_ve = [get(trail_ve, 'XData'), tspan(i)];
    y_trail_ve = [get(trail_ve, 'YData'), V(4)];

    x_trail_vf = [get(trail_vf, 'XData'), tspan(i)];
    y_trail_vf = [get(trail_vf, 'YData'), V(6)];
    
    set(trail_va, 'XData', x_trail_va, 'YData', y_trail_va);
    set(trail_vb, 'XData', x_trail_vb, 'YData', y_trail_vb);
    set(trail_vc, 'XData', x_trail_vc, 'YData', y_trail_vc);
    set(trail_vd, 'XData', x_trail_vd, 'YData', y_trail_vd);
    set(trail_ve, 'XData', x_trail_ve, 'YData', y_trail_ve);
    set(trail_vf, 'XData', x_trail_vf, 'YData', y_trail_vf);


    xlim(ax1,[0.5, 0.7]);
    ylim(ax1,[-1.1, 1.1])

    drawnow
end

drawnow
