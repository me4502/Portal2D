var wkey = key;

for(var i = 0; i < instance_number(ConditionalWallObject); i++) {
  with(instance_find(ConditionalWallObject, i)) {
      if(wkey == key) {
        image_index = 0;
        isOpen = 1;
      }
  }
}

for(var i = 0; i < instance_number(WallObject); i++) {
  with(instance_find(WallObject, i)) {
      if(direction == 180) {
          if(wkey == key) {
            image_index = 0;
            isOpen = 0;
          }
      }
  }
}

for(var i = 0; i < instance_number(FaithPlateObject); i++) {
  with(instance_find(FaithPlateObject, i)) {
      if(depth == -1) {
          if(wkey == key) {
            isOpen = 1;
          }
      }
  }
}

image_index = 1;
