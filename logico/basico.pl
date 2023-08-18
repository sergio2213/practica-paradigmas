habitat(jirafa, sabana).
habitat(tigre, sabana).
habitat(tigre, bosque).
habitat(tiburon, mar).

% un animal es acuático si vive en el mar
esAcuatico(Animal) :- habitat(Animal, mar).

% todos los animales que no son acuáticos
terrestre(Animal) :- habitat(Animal, _), not(habitat(Animal, mar)).