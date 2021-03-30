@[Link(ldflags: "-L#{__DIR__}/../bin/libs -lwgpu_native")]
lib LibWGPU
  MAX_BIND_GROUPS = 8
  MAX_COLOR_TARGETS = 4
  MAX_MIP_LEVELS = 16
  MAX_VERTEX_BUFFERS = 16
  MAX_ANISOTROPY = 16
  SHADER_STAGE_COUNT = 3
  DESIRED_NUM_FRAMES = 3
  COPY_BYTES_PER_ROW_ALIGNMENT = 256
  PUSH_CONSTANT_ALIGNMENT = 4
  QUERY_SET_MAX_QUERIES = 8192
  QUERY_SIZE = 8
  # Origin3d_ZERO = ( Origin3d){. x=0,. y=0,. z=0}
  # Color_TRANSPARENT = ( Color){. r=0.0,. g=0.0,. b=0.0,. a=0.0}
  # Color_BLACK = ( Color){. r=0.0,. g=0.0,. b=0.0,. a=1.0}
  # Color_WHITE = ( Color){. r=1.0,. g=1.0,. b=1.0,. a=1.0}
  # Color_RED = ( Color){. r=1.0,. g=0.0,. b=0.0,. a=1.0}
  # Color_GREEN = ( Color){. r=0.0,. g=1.0,. b=0.0,. a=1.0}
  # Color_BLUE = ( Color){. r=0.0,. g=0.0,. b=1.0,. a=1.0}
  # Features_DEPTH_CLAMPING = ( uint64_t)1
  # Features_TEXTURE_COMPRESSION_BC = ( uint64_t)2
  # Features_TIMESTAMP_QUERY = ( uint64_t)4
  # Features_PIPELINE_STATISTICS_QUERY = ( uint64_t)8
  # Features_MAPPABLE_PRIMARY_BUFFERS = ( uint64_t)65536
  # Features_SAMPLED_TEXTURE_BINDING_ARRAY = ( uint64_t)131072
  # Features_SAMPLED_TEXTURE_ARRAY_DYNAMIC_INDEXING = ( uint64_t)262144
  # Features_SAMPLED_TEXTURE_ARRAY_NON_UNIFORM_INDEXING = ( uint64_t)524288
  # Features_UNSIZED_BINDING_ARRAY = ( uint64_t)1048576
  # Features_MULTI_DRAW_INDIRECT = ( uint64_t)2097152
  # Features_MULTI_DRAW_INDIRECT_COUNT = ( uint64_t)4194304
  # Features_PUSH_CONSTANTS = ( uint64_t)8388608
  # Features_ADDRESS_MODE_CLAMP_TO_BORDER = ( uint64_t)16777216
  # Features_NON_FILL_POLYGON_MODE = ( uint64_t)33554432
  # WGPUFeatures_TEXTURE_COMPRESSION_ETC2 = ( uint64_t)67108864
  # Features_TEXTURE_COMPRESSION_ASTC_LDR = ( uint64_t)134217728
  # Features_TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES = ( uint64_t)268435456
  # WGPUFeatures_SHADER_FLOAT64 = ( uint64_t)536870912
  # WGPUFeatures_VERTEX_ATTRIBUTE_64BIT = ( uint64_t)1073741824
  # Features_ALL_WEBGPU = ( uint64_t)65535
  # Features_ALL_NATIVE = ( uint64_t)UInt64.new(18446744073709486080)
  # BufferUsage_MAP_READ = ( uint32_t)1
  # BufferUsage_MAP_WRITE = ( uint32_t)2
  # BufferUsage_COPY_SRC = ( uint32_t)4
  # BufferUsage_COPY_DST = ( uint32_t)8
  # BufferUsage_INDEX = ( uint32_t)16
  # BufferUsage_VERTEX = ( uint32_t)32
  # BufferUsage_UNIFORM = ( uint32_t)64
  # BufferUsage_STORAGE = ( uint32_t)128
  # BufferUsage_INDIRECT = ( uint32_t)256
  # TextureUsage_COPY_SRC = ( uint32_t)1
  # TextureUsage_COPY_DST = ( uint32_t)2
  # TextureUsage_SAMPLED = ( uint32_t)4
  # TextureUsage_STORAGE = ( uint32_t)8
  # TextureUsage_RENDER_ATTACHMENT = ( uint32_t)16
  # ShaderStage_NONE = ( uint32_t)0
  # ShaderStage_VERTEX = ( uint32_t)1
  # ShaderStage_FRAGMENT = ( uint32_t)2
  # ShaderStage_COMPUTE = ( uint32_t)4
  # ShaderFlags_VALIDATION = ( uint32_t)1
  # ShaderFlags_EXPERIMENTAL_TRANSLATION = ( uint32_t)2
  # ColorWrite_RED = ( uint32_t)1
  # ColorWrite_GREEN = ( uint32_t)2
  # ColorWrite_BLUE = ( uint32_t)4
  # ColorWrite_ALPHA = ( uint32_t)8
  # ColorWrite_COLOR = ( uint32_t)7
  # ColorWrite_ALL = ( uint32_t)15
  BIND_BUFFER_ALIGNMENT = 256
  COPY_BUFFER_ALIGNMENT = 4
  VERTEX_STRIDE_ALIGNMENT = 4
  alias Option_AdapterId = UInt64
  alias Option_BufferId = UInt64
  alias Option_SamplerId = UInt64
  alias Option_SurfaceId = UInt64
  alias Option_TextureViewId = UInt64
  alias Option_BufferSize = UInt64
  alias Option_PipelineLayoutId = UInt64
  enum AddressMode : UInt32
    ClampToEdge = 0
    Repeat = 1
    MirrorRepeat = 2
    ClampToBorder = 3
  end
  enum Backend : UInt32
    Empty = 0
    Vulkan = 1
    Metal = 2
    Dx12 = 3
    Dx11 = 4
    Gl = 5
    BrowserWebGpu = 6
  end
  # alias Backend = UInt8
  enum BindingType : UInt32
    UniformBuffer = 0
    StorageBuffer = 1
    ReadonlyStorageBuffer = 2
    Sampler = 3
    ComparisonSampler = 4
    SampledTexture = 5
    ReadonlyStorageTexture = 6
    WriteonlyStorageTexture = 7
  end
  # alias BindingType = UInt32
  enum BlendFactor : UInt32
    Zero = 0
    One = 1
    SrcColor = 2
    OneMinusSrcColor = 3
    SrcAlpha = 4
    OneMinusSrcAlpha = 5
    DstColor = 6
    OneMinusDstColor = 7
    DstAlpha = 8
    OneMinusDstAlpha = 9
    SrcAlphaSaturated = 10
    BlendColor = 11
    OneMinusBlendColor = 12
  end
  enum BlendOperation : UInt32
    Add = 0
    Subtract = 1
    ReverseSubtract = 2
    Min = 3
    Max = 4
  end
  enum BufferMapAsyncStatus : UInt32
    Success = 0
    Error = 1
    Unknown = 2
    ContextLost = 3
  end
  enum DeviceType : UInt32
    Other = 0
    IntegratedGpu = 1
    DiscreteGpu = 2
    VirtualGpu = 3
    Cpu = 4
  end
  # alias DeviceType = UInt8
  enum CompareFunction : UInt32
    Undefined = 0
    Never = 1
    Less = 2
    LessEqual = 3
    Greater = 4
    GreaterEqual = 5
    Equal = 6
    NotEqual = 7
    Always = 8
  end
  # alias CompareFunction = UInt32
  enum CullMode : UInt32
    None = 0
    Front = 1
    Back = 2
  end
  # alias CullMode = UInt32
  enum FilterMode : UInt32
    Nearest = 0
    Linear = 1
  end
  enum FrontFace : UInt32
    Ccw = 0
    Cw = 1
  end
  enum IndexFormat : UInt32
    Undefined = 0
    Uint16 = 1
    Uint32 = 2
  end
  # alias IndexFormat = UInt32
  enum InputStepMode : UInt32
    Vertex = 0
    Instance = 1
  end
  enum LoadOp : UInt32
    Clear = 0
    Load = 1
  end
  enum LogLevel : UInt32
    Off = 0
    Error = 1
    Warn = 2
    Info = 3
    Debug = 4
    Trace = 5
  end
  enum PolygonMode : UInt32
    Fill = 0
    Line = 1
    Point = 2
  end
  enum PowerPreference : UInt32
    LowPower = 0
    HighPerformance = 1
  end
  enum PresentMode : UInt32
    Immediate = 0
    Mailbox = 1
    Fifo = 2
  end
  enum PrimitiveTopology : UInt32
    PointList = 0
    LineList = 1
    LineStrip = 2
    TriangleList = 3
    TriangleStrip = 4
  end
  enum SType : UInt32
    Invalid = 0
    SurfaceDescriptorFromMetalLayer = 1
    SurfaceDescriptorFromWindowsHWND = 2
    SurfaceDescriptorFromXlib = 3
    SurfaceDescriptorFromHTMLCanvasId = 4
    ShaderModuleSPIRVDescriptor = 5
    ShaderModuleWGSLDescriptor = 6
    AnisotropicFiltering = 268435456
    Force32 = 2147483647
  end
  # alias SType = UInt32
  enum SamplerBorderColor : UInt32
    TransparentBlack = 0
    OpaqueBlack = 1
    OpaqueWhite = 2
  end
  enum StencilOperation : UInt32
    Keep = 0
    Zero = 1
    Replace = 2
    Invert = 3
    IncrementClamp = 4
    DecrementClamp = 5
    IncrementWrap = 6
    DecrementWrap = 7
  end
  enum StoreOp : UInt32
    Clear = 0
    Store = 1
  end
  enum SwapChainStatus : UInt32
    Good = 0
    Suboptimal = 1
    Timeout = 2
    Outdated = 3
    Lost = 4
  end
  enum TextureAspect : UInt32
    All = 0
    StencilOnly = 1
    DepthOnly = 2
  end
  enum TextureComponentType : UInt32
    Float32 = 0
    Sint = 1
    UInt32 = 2
    DepthComparison = 3
  end
  # alias TextureComponentType = UInt32
  enum TextureDimension : UInt32
    D1 = 0
    D2 = 1
    D3 = 2
  end
  enum TextureFormat : UInt32
    R8Unorm = 0
    R8Snorm = 1
    R8Uint = 2
    R8Sint = 3
    R16Uint = 4
    R16Sint = 5
    R16Float = 6
    Rg8Unorm = 7
    Rg8Snorm = 8
    Rg8Uint = 9
    Rg8Sint = 10
    R32Uint = 11
    R32Sint = 12
    R32Float = 13
    Rg16Uint = 14
    Rg16Sint = 15
    Rg16Float = 16
    Rgba8Unorm = 17
    Rgba8UnormSrgb = 18
    Rgba8Snorm = 19
    Rgba8Uint = 20
    Rgba8Sint = 21
    Bgra8Unorm = 22
    Bgra8UnormSrgb = 23
    Rgb10a2Unorm = 24
    Rg11b10Float = 25
    Rg32Uint = 26
    Rg32Sint = 27
    Rg32Float = 28
    Rgba16Uint = 29
    Rgba16Sint = 30
    Rgba16Float = 31
    Rgba32Uint = 32
    Rgba32Sint = 33
    Rgba32Float = 34
    Depth32Float = 35
    Depth24Plus = 36
    Depth24PlusStencil8 = 37
    Bc1RgbaUnorm = 38
    Bc1RgbaUnormSrgb = 39
    Bc2RgbaUnorm = 40
    Bc2RgbaUnormSrgb = 41
    Bc3RgbaUnorm = 42
    Bc3RgbaUnormSrgb = 43
    Bc4RUnorm = 44
    Bc4RSnorm = 45
    Bc5RgUnorm = 46
    Bc5RgSnorm = 47
    Bc6hRgbUfloat = 48
    Bc6hRgbSfloat = 49
    Bc7RgbaUnorm = 50
    Bc7RgbaUnormSrgb = 51
    Etc2RgbUnorm = 52
    Etc2RgbUnormSrgb = 53
    Etc2RgbA1Unorm = 54
    Etc2RgbA1UnormSrgb = 55
    Etc2RgbA8Unorm = 56
    Etc2RgbA8UnormSrgb = 57
    EacRUnorm = 58
    EacRSnorm = 59
    EtcRgUnorm = 60
    EtcRgSnorm = 61
    Astc4x4RgbaUnorm = 62
    Astc4x4RgbaUnormSrgb = 63
    Astc5x4RgbaUnorm = 64
    Astc5x4RgbaUnormSrgb = 65
    Astc5x5RgbaUnorm = 66
    Astc5x5RgbaUnormSrgb = 67
    Astc6x5RgbaUnorm = 68
    Astc6x5RgbaUnormSrgb = 69
    Astc6x6RgbaUnorm = 70
    Astc6x6RgbaUnormSrgb = 71
    Astc8x5RgbaUnorm = 72
    Astc8x5RgbaUnormSrgb = 73
    Astc8x6RgbaUnorm = 74
    Astc8x6RgbaUnormSrgb = 75
    Astc10x5RgbaUnorm = 76
    Astc10x5RgbaUnormSrgb = 77
    Astc10x6RgbaUnorm = 78
    Astc10x6RgbaUnormSrgb = 79
    Astc8x8RgbaUnorm = 80
    Astc8x8RgbaUnormSrgb = 81
    Astc10x8RgbaUnorm = 82
    Astc10x8RgbaUnormSrgb = 83
    Astc10x10RgbaUnorm = 84
    Astc10x10RgbaUnormSrgb = 85
    Astc12x10RgbaUnorm = 86
    Astc12x10RgbaUnormSrgb = 87
    Astc12x12RgbaUnorm = 88
    Astc12x12RgbaUnormSrgb = 89
  end
  enum TextureViewDimension : UInt32
    D1 = 0
    D2 = 1
    D2Array = 2
    Cube = 3
    CubeArray = 4
    D3 = 5
  end
  enum VertexFormat : UInt32
    Uchar2 = 0
    Uchar4 = 1
    Char2 = 2
    Char4 = 3
    Uchar2Norm = 4
    Uchar4Norm = 5
    Char2Norm = 6
    Char4Norm = 7
    Ushort2 = 8
    Ushort4 = 9
    Short2 = 10
    Short4 = 11
    Ushort2Norm = 12
    Ushort4Norm = 13
    Short2Norm = 14
    Short4Norm = 15
    Half2 = 16
    Half4 = 17
    Float32 = 18
    Float2 = 19
    Float3 = 20
    Float4 = 21
    UInt32 = 22
    Uint2 = 23
    Uint3 = 24
    Uint4 = 25
    Int = 26
    Int2 = 27
    Int3 = 28
    Int4 = 29
    Double = 30
    Double2 = 31
    Double3 = 32
    Double4 = 33
  end
  type ComputePass = Void
  type RenderBundleEncoder = Void
  type RenderPass = Void
  alias Id_CommandBuffer_Dummy = UInt64
  alias CommandBufferId = Id_CommandBuffer_Dummy
  alias CommandEncoderId = CommandBufferId
  alias Label = Char*
  struct CommandBufferDescriptor
    label : Label
  end
  alias Id_Buffer_Dummy = UInt64
  alias BufferId = Id_Buffer_Dummy
  alias BufferAddress = UInt64
  struct TextureDataLayout
    offset : BufferAddress
    bytes_per_row : UInt32
    rows_per_image : UInt32
  end
  struct BufferCopyView
    layout : TextureDataLayout
    buffer : BufferId
  end
  alias Id_Texture_Dummy = UInt64
  alias TextureId = Id_Texture_Dummy
  struct Origin3d
    x : UInt32
    y : UInt32
    z : UInt32
  end
  struct TextureCopyView
    texture : TextureId
    mip_level : UInt32
    origin : Origin3d
  end
  struct Extent3d
    width : UInt32
    height : UInt32
    depth : UInt32
  end
  alias Id_TextureView_Dummy = UInt64
  alias TextureViewId = Id_TextureView_Dummy
  struct Color
    r : Float64
    g : Float64
    b : Float64
    a : Float64
  end
  struct PassChannel_Color
    load_op : LoadOp
    store_op : StoreOp
    clear_value : Color
    read_only : Bool
  end
  struct ColorAttachmentDescriptor
    attachment : TextureViewId
    resolve_target : Option_TextureViewId
    channel : PassChannel_Color
  end
  struct WGPUPassChannel_f32
    load_op : LoadOp
    store_op : StoreOp
    clear_value : Float32
    read_only : Bool
  end
  struct WGPUPassChannel_u32
    load_op : LoadOp
    store_op : StoreOp
    clear_value : UInt32
    read_only : Bool
  end
  struct DepthStencilAttachmentDescriptor
    attachment : TextureViewId
    depth : WGPUPassChannel_f32
    stencil : WGPUPassChannel_u32
  end
  struct RenderPassDescriptor
    color_attachments : ColorAttachmentDescriptor*
    color_attachments_length : UInt32
    depth_stencil_attachment : DepthStencilAttachmentDescriptor*
    label : Label
  end
  struct ComputePassDescriptor
    label : Label
  end
  alias Id_Surface = UInt64
  alias SurfaceId = Id_Surface
  struct RequestAdapterOptions
    power_preference : PowerPreference
    compatible_surface : Option_SurfaceId
  end
  alias BackendBit = UInt32
  alias Id_Adapter_Dummy = UInt64
  alias AdapterId = Id_Adapter_Dummy
  alias RequestAdapterCallback = (AdapterId, Void*) -> Void
  alias Id_Device_Dummy = UInt64
  alias DeviceId = Id_Device_Dummy
  alias Features = UInt64
  struct Limits
    max_bind_groups : UInt32
  end
  struct DeviceDescriptor
    label : Label
    features : Features
    limits : Limits
    trace_path : Char*
  end
  alias BufferUsage = UInt32
  struct BufferDescriptor
    label : Label
    size : BufferAddress
    usage : BufferUsage
    mapped_at_creation : Bool
  end
  alias TextureUsage = UInt32
  struct TextureDescriptor
    label : Label
    size : Extent3d
    mip_level_count : UInt32
    sample_count : UInt32
    dimension : TextureDimension
    format : TextureFormat
    usage : TextureUsage
  end
  struct TextureViewDescriptor
    label : Label
    format : TextureFormat
    dimension : TextureViewDimension
    aspect : TextureAspect
    base_mip_level : UInt32
    level_count : UInt32
    base_array_layer : UInt32
    array_layer_count : UInt32
  end
  alias Id_Sampler_Dummy = UInt64
  alias SamplerId = Id_Sampler_Dummy
  struct ChainedStruct
    next_ : ChainedStruct*
    s_type : SType
  end
  struct SamplerDescriptor
    next_in_chain : ChainedStruct*
    label : Label
    address_mode_u : AddressMode
    address_mode_v : AddressMode
    address_mode_w : AddressMode
    mag_filter : FilterMode
    min_filter : FilterMode
    mipmap_filter : FilterMode
    lod_min_clamp : Float32
    lod_max_clamp : Float32
    compare : CompareFunction
    border_color : SamplerBorderColor
  end
  alias Id_BindGroupLayout_Dummy = UInt64
  alias BindGroupLayoutId = Id_BindGroupLayout_Dummy
  alias ShaderStage = UInt32
  struct BindGroupLayoutEntry
    binding : UInt32
    visibility : ShaderStage
    ty : BindingType
    has_dynamic_offset : Bool
    min_buffer_binding_size : UInt64
    multisampled : Bool
    filtering : Bool
    view_dimension : TextureViewDimension
    texture_component_type : TextureComponentType
    storage_texture_format : TextureFormat
    count : UInt32
  end
  struct BindGroupLayoutDescriptor
    label : Label
    entries : BindGroupLayoutEntry*
    entries_length : UInt32
  end
  alias Id_PipelineLayout_Dummy = UInt64
  alias PipelineLayoutId = Id_PipelineLayout_Dummy
  struct PipelineLayoutDescriptor
    label : Label
    bind_group_layouts : BindGroupLayoutId*
    bind_group_layouts_length : UInt32
  end
  alias Id_BindGroup_Dummy = UInt64
  alias BindGroupId = Id_BindGroup_Dummy
  alias BufferSize = UInt64
  struct BindGroupEntry
    binding : UInt32
    buffer : Option_BufferId
    offset : BufferAddress
    size : BufferSize
    sampler : Option_SamplerId
    texture_view : Option_TextureViewId
  end
  struct BindGroupDescriptor
    label : Label
    layout : BindGroupLayoutId
    entries : BindGroupEntry*
    entries_length : UInt32
  end
  alias Id_ShaderModule_Dummy = UInt64
  alias ShaderModuleId = Id_ShaderModule_Dummy
  alias ShaderFlags = UInt32
  struct ShaderModuleDescriptor
    next_in_chain : ChainedStruct*
    label : Label
    flags : ShaderFlags
  end
  struct CommandEncoderDescriptor
    label : Label
  end
  alias RenderBundleEncoderId = RenderBundleEncoder*
  struct RenderBundleEncoderDescriptor
    label : Label
    color_formats : TextureFormat*
    color_formats_length : UInt32
    depth_stencil_format : TextureFormat*
    sample_count : UInt32
  end
  alias Id_RenderBundle = UInt64
  alias RenderBundleId = Id_RenderBundle
  struct RenderBundleDescriptor_Label
    label : Label
  end
  alias QueueId = DeviceId
  alias Id_RenderPipeline_Dummy = UInt64
  alias RenderPipelineId = Id_RenderPipeline_Dummy
  struct ProgrammableStageDescriptor
    module : ShaderModuleId
    entry_point : Label
  end
  struct VertexAttributeDescriptor
    format : VertexFormat
    offset : UInt64
    shader_location : UInt32
  end
  struct VertexBufferLayoutDescriptor
    array_stride : UInt64
    step_mode : InputStepMode
    attribute_count : UInt32
    attributes : VertexAttributeDescriptor*
  end
  struct VertexStateDescriptor
    next_in_chain : ChainedStruct*
    index_format : IndexFormat
    vertex_buffer_count : UInt32
    vertex_buffers : VertexBufferLayoutDescriptor*
  end
  struct RasterizationStateDescriptor
    next_in_chain : ChainedStruct*
    front_face : FrontFace
    cull_mode : CullMode
    depth_bias : Int32
    depth_bias_slope_scale : Float32
    depth_bias_clamp : Float32
    clamp_depth : Bool
    polygon_mode : PolygonMode
  end
  struct StencilStateFaceDescriptor
    compare : CompareFunction
    fail_op : StencilOperation
    depth_fail_op : StencilOperation
    pass_op : StencilOperation
  end
  struct DepthStencilStateDescriptor
    next_in_chain : ChainedStruct*
    format : TextureFormat
    depth_write_enabled : Bool
    depth_compare : CompareFunction
    stencil_front : StencilStateFaceDescriptor
    stencil_back : StencilStateFaceDescriptor
    stencil_read_mask : UInt32
    stencil_write_mask : UInt32
  end
  struct BlendDescriptor
    operation : BlendOperation
    src_factor : BlendFactor
    dst_factor : BlendFactor
  end
  alias ColorWrite = UInt32
  struct ColorStateDescriptor
    next_in_chain : ChainedStruct*
    format : TextureFormat
    alpha_blend : BlendDescriptor
    color_blend : BlendDescriptor
    write_mask : ColorWrite
  end
  struct RenderPipelineDescriptor
    next_in_chain : ChainedStruct*
    label : Label
    layout : Option_PipelineLayoutId
    vertex_stage : ProgrammableStageDescriptor
    fragment_stage : ProgrammableStageDescriptor*
    vertex_state : VertexStateDescriptor
    primitive_topology : PrimitiveTopology
    rasterization_state : RasterizationStateDescriptor
    sample_count : UInt32
    depth_stencil_state : DepthStencilStateDescriptor*
    color_state_count : UInt32
    color_states : ColorStateDescriptor*
    sample_mask : UInt32
    alpha_to_coverage_enabled : Bool
  end
  alias Id_ComputePipeline_Dummy = UInt64
  alias ComputePipelineId = Id_ComputePipeline_Dummy
  struct ComputePipelineDescriptor
    label : Label
    layout : Option_PipelineLayoutId
    stage : ProgrammableStageDescriptor
  end
  alias Id_SwapChain_Dummy = UInt64
  alias SwapChainId = Id_SwapChain_Dummy
  struct SwapChainDescriptor
    usage : TextureUsage
    format : TextureFormat
    width : UInt32
    height : UInt32
    present_mode : PresentMode
  end
  alias BufferMapCallback = (BufferMapAsyncStatus, Void*) -> Void
  struct AdapterInfo
    name : Char*
    name_length : UInt32
    vendor : UInt32
    device : UInt32
    device_type : DeviceType
    backend : Backend
  end
  alias LogCallback = (Int32, Char*) -> Void
  alias DynamicOffset = UInt32
  alias RawString = Char*
  alias Id_QuerySet_Dummy = UInt64
  alias QuerySetId = Id_QuerySet_Dummy
  struct AnisotropicSamplerDescriptorExt
    next_in_chain : ChainedStruct*
    s_type : SType
    anisotropic_clamp : UInt8
  end
  struct ShaderModuleSPIRVDescriptor
    chain : ChainedStruct
    code_size : UInt32
    code : UInt32*
  end
  struct ShaderModuleWGSLDescriptor
    chain : ChainedStruct
    source : Char*
  end
  fun wgpu_get_version() : UInt32
  fun wgpu_command_encoder_finish(CommandEncoderId, CommandBufferDescriptor*) : CommandBufferId
  fun wgpu_command_encoder_copy_buffer_to_buffer(CommandEncoderId, BufferId, BufferAddress, BufferId, BufferAddress, BufferAddress) : Void
  fun wgpu_command_encoder_copy_buffer_to_texture(CommandEncoderId, BufferCopyView*, TextureCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_buffer(CommandEncoderId, TextureCopyView*, BufferCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_texture(CommandEncoderId, TextureCopyView*, TextureCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_begin_render_pass(CommandEncoderId, RenderPassDescriptor*) : RenderPass*
  fun wgpu_render_pass_end_pass(RenderPass*) : Void
  fun wgpu_render_pass_destroy(RenderPass*) : Void
  fun wgpu_command_encoder_begin_compute_pass(CommandEncoderId, ComputePassDescriptor*) : ComputePass*
  fun wgpu_compute_pass_end_pass(ComputePass*) : Void
  fun wgpu_compute_pass_destroy(ComputePass*) : Void
  fun wgpu_render_pass_set_index_buffer(RenderPass*, BufferId, IndexFormat, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_bundle_set_index_buffer(RenderBundleEncoder*, BufferId, IndexFormat, BufferAddress, Option_BufferSize) : Void
  fun wgpu_create_surface_from_xlib(Void**, UInt64) : SurfaceId
  fun wgpu_create_surface_from_wayland(Void*, Void*) : SurfaceId
  fun wgpu_create_surface_from_android(Void*) : SurfaceId
  fun wgpu_create_surface_from_metal_layer(Void*) : SurfaceId
  fun wgpu_create_surface_from_windows_hwnd(Void*, Void*) : SurfaceId
  fun wgpu_request_adapter_async(RequestAdapterOptions*, BackendBit, RequestAdapterCallback, Void*) : Void
  fun wgpu_adapter_request_device(AdapterId, DeviceDescriptor*) : DeviceId
  fun wgpu_adapter_features(AdapterId) : Features
  fun wgpu_adapter_limits(AdapterId) : Limits
  fun wgpu_adapter_destroy(AdapterId) : Void
  fun wgpu_device_features(DeviceId) : Features
  fun wgpu_device_limits(DeviceId) : Limits
  fun wgpu_device_create_buffer(DeviceId, BufferDescriptor*) : BufferId
  fun wgpu_buffer_destroy(BufferId, Bool) : Void
  fun wgpu_device_create_texture(DeviceId, TextureDescriptor*) : TextureId
  fun wgpu_texture_destroy(TextureId, Bool) : Void
  fun wgpu_texture_create_view(TextureId, TextureViewDescriptor*) : TextureViewId
  fun wgpu_texture_view_destroy(TextureViewId, Bool) : Void
  fun wgpu_device_create_sampler(DeviceId, SamplerDescriptor*) : SamplerId
  fun wgpu_sampler_destroy(SamplerId) : Void
  fun wgpu_device_create_bind_group_layout(DeviceId, BindGroupLayoutDescriptor*) : BindGroupLayoutId
  fun wgpu_bind_group_layout_destroy(BindGroupLayoutId) : Void
  fun wgpu_device_create_pipeline_layout(DeviceId, PipelineLayoutDescriptor*) : PipelineLayoutId
  fun wgpu_pipeline_layout_destroy(PipelineLayoutId) : Void
  fun wgpu_device_create_bind_group(DeviceId, BindGroupDescriptor*) : BindGroupId
  fun wgpu_bind_group_destroy(BindGroupId) : Void
  fun wgpu_device_create_shader_module(DeviceId, ShaderModuleDescriptor*) : ShaderModuleId
  fun wgpu_shader_module_destroy(ShaderModuleId) : Void
  fun wgpu_device_create_command_encoder(DeviceId, CommandEncoderDescriptor*) : CommandEncoderId
  fun wgpu_command_encoder_destroy(CommandEncoderId) : Void
  fun wgpu_command_buffer_destroy(CommandBufferId) : Void
  fun wgpu_device_create_render_bundle_encoder(DeviceId, RenderBundleEncoderDescriptor*) : RenderBundleEncoderId
  fun wgpu_render_bundle_encoder_finish(RenderBundleEncoderId, RenderBundleDescriptor_Label*) : RenderBundleId
  fun wgpu_render_bundle_destroy(RenderBundleId) : Void
  fun wgpu_device_get_default_queue(DeviceId) : QueueId
  fun wgpu_queue_write_buffer(QueueId, BufferId, BufferAddress, UInt8*, UInt32) : Void
  fun wgpu_queue_write_texture(QueueId, TextureCopyView*, UInt8*, UInt32, TextureDataLayout*, Extent3d*) : Void
  fun wgpu_queue_submit(QueueId, CommandBufferId*, UInt32) : Void
  fun wgpuDeviceCreateRenderPipeline(DeviceId, RenderPipelineDescriptor*) : RenderPipelineId
  fun wgpu_render_pipeline_destroy(RenderPipelineId) : Void
  fun wgpu_device_create_compute_pipeline(DeviceId, ComputePipelineDescriptor*) : ComputePipelineId
  fun wgpu_compute_pipeline_destroy(ComputePipelineId) : Void
  fun wgpu_device_create_swap_chain(DeviceId, SurfaceId, SwapChainDescriptor*) : SwapChainId
  fun wgpu_device_poll(DeviceId, Bool) : Void
  fun wgpu_device_destroy(DeviceId) : Void
  fun wgpu_buffer_map_read_async(BufferId, BufferAddress, BufferAddress, BufferMapCallback, Void*) : Void
  fun wgpu_buffer_map_write_async(BufferId, BufferAddress, BufferAddress, BufferMapCallback, Void*) : Void
  fun wgpu_buffer_unmap(BufferId) : Void
  fun wgpu_swap_chain_get_current_texture_view(SwapChainId) : Option_TextureViewId
  fun wgpu_swap_chain_present(SwapChainId) : SwapChainStatus
  fun wgpu_buffer_get_mapped_range(BufferId, BufferAddress, BufferSize) : UInt8*
  fun wgpu_adapter_get_info(AdapterId, AdapterInfo*) : Void
  fun wgpu_set_log_callback(LogCallback) : Void
  fun wgpu_set_log_level(LogLevel) : Int32
  fun wgpu_render_bundle_set_bind_group(RenderBundleEncoder*, UInt32, BindGroupId, DynamicOffset*, UInt32) : Void
  fun wgpu_render_bundle_set_pipeline(RenderBundleEncoder*, RenderPipelineId) : Void
  fun wgpu_render_bundle_set_vertex_buffer(RenderBundleEncoder*, UInt32, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_bundle_set_push_constants(RenderBundleEncoder*, ShaderStage, UInt32, UInt32, UInt8*) : Void
  fun wgpu_render_bundle_draw(RenderBundleEncoder*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_bundle_draw_indexed(RenderBundleEncoder*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_bundle_draw_indirect(RenderBundleEncoder*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_bundle_indexed_indirect(RenderBundleEncoder*, BufferId, BufferAddress) : Void
  fun wgpu_render_bundle_push_debug_group(RenderBundleEncoder*, RawString) : Void
  fun wgpu_render_bundle_pop_debug_group(RenderBundleEncoder*) : Void
  fun wgpu_render_bundle_insert_debug_marker(RenderBundleEncoder*, RawString) : Void
  fun wgpu_compute_pass_set_bind_group(ComputePass*, UInt32, BindGroupId, DynamicOffset*, UInt32) : Void
  fun wgpu_compute_pass_set_pipeline(ComputePass*, ComputePipelineId) : Void
  fun wgpu_compute_pass_set_push_constant(ComputePass*, UInt32, UInt32, UInt8*) : Void
  fun wgpu_compute_pass_dispatch(ComputePass*, UInt32, UInt32, UInt32) : Void
  fun wgpu_compute_pass_dispatch_indirect(ComputePass*, BufferId, BufferAddress) : Void
  fun wgpu_compute_pass_push_debug_group(ComputePass*, RawString, UInt32) : Void
  fun wgpu_compute_pass_pop_debug_group(ComputePass*) : Void
  fun wgpu_compute_pass_insert_debug_marker(ComputePass*, RawString, UInt32) : Void
  fun wgpu_compute_pass_write_timestamp(ComputePass*, QuerySetId, UInt32) : Void
  fun wgpu_compute_pass_begin_pipeline_statistics_query(ComputePass*, QuerySetId, UInt32) : Void
  fun wgpu_compute_pass_end_pipeline_statistics_query(ComputePass*) : Void
  fun wgpu_render_pass_set_bind_group(RenderPass*, UInt32, BindGroupId, DynamicOffset*, UInt32) : Void
  fun wgpu_render_pass_set_pipeline(RenderPass*, RenderPipelineId) : Void
  fun wgpu_render_pass_set_vertex_buffer(RenderPass*, UInt32, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_pass_set_blend_color(RenderPass*, Color*) : Void
  fun wgpu_render_pass_set_stencil_reference(RenderPass*, UInt32) : Void
  fun wgpu_render_pass_set_viewport(RenderPass*, Float32, Float32, Float32, Float32, Float32, Float32) : Void
  fun wgpu_render_pass_set_scissor_rect(RenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_set_push_constants(RenderPass*, ShaderStage, UInt32, UInt32, UInt8*) : Void
  fun wgpu_render_pass_draw(RenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed(RenderPass*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_pass_draw_indirect(RenderPass*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_draw_indexed_indirect(RenderPass*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_multi_draw_indirect(RenderPass*, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect(RenderPass*, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indirect_count(RenderPass*, BufferId, BufferAddress, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect_count(RenderPass*, BufferId, BufferAddress, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_push_debug_group(RenderPass*, RawString, UInt32) : Void
  fun wgpu_render_pass_pop_debug_group(RenderPass*) : Void
  fun wgpu_render_pass_insert_debug_marker(RenderPass*, RawString, UInt32) : Void
  fun wgpu_render_pass_write_timestamp(RenderPass*, QuerySetId, UInt32) : Void
  fun wgpu_render_pass_begin_pipeline_statistics_query(RenderPass*, QuerySetId, UInt32) : Void
  fun wgpu_render_pass_end_pipeline_statistics_query(RenderPass*) : Void
end
