-- Generated from ChapterL2FibreSum.lean — theorem BookProof.ChapterL2FibreSum.coordCLM_apply
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterHilbertSumIntertwine
import Mathlib
import Definitions.Def_ChapterL2FibreSum
open BookProof.ChapterL2FibreSum


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]

theorem BookProof.ChapterL2FibreSum.coordCLM_apply (i : ι) (w : Fibre ι) : coordCLM i w = w i := by sorry
