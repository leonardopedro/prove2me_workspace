-- Generated from ChapterL2FibreSum.lean — theorem BookProof.ChapterL2FibreSum.projCLM_apply
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterA4
open BookProof.ChapterElectroweakFieldStrength

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open MeasureTheory
open scoped InnerProductSpace




theorem BookProof.ChapterL2FibreSum.projCLM_apply (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (f : Lp K 2 μ) : projCLM μ hE f = proj μ hE f := by sorry
