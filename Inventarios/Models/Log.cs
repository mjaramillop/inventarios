﻿using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Log
{
    public int id { get; set; }

    public string? descripciondelaoperacion { get; set; }

    public DateTime? fechadeactualizacion { get; set; }
}
