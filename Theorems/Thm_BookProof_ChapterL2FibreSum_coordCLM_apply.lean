-- Generated from ChapterL2FibreSum.lean — theorem BookProof.ChapterL2FibreSum.coordCLM_apply
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Definitions.Def_ChapterA4

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]


open MeasureTheory
open scoped InnerProductSpace




theorem BookProof.ChapterL2FibreSum.coordCLM_apply (i : ι) (w : Fibre ι) : coordCLM i w = w i := by sorry
