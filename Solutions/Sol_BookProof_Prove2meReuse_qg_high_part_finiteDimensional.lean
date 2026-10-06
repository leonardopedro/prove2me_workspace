-- Generated from ChapterProve2meReuse.lean — solution of BookProof.Prove2meReuse.qg_high_part_finiteDimensional
import Mathlib
import Definitions.Def_ChapterProve2meReuse
open BookProof.Prove2meReuse



open MeasureTheory
open scoped Convolution

set_option maxHeartbeats 1000000 in
theorem solution (H : RouteHypotheses) :
    CompactSymmetricHighPart := H.compact_symmetric_high_part
