-- Generated from ChapterL2FibreSum.lean — theorem BookProof.ChapterL2FibreSum.fibreEmb_proj
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterHilbertSumIntertwine
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterL2FibreSum


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]

theorem BookProof.ChapterL2FibreSum.fibreEmb_proj (μ : Measure X) (i : ι) {E : Set X} (hE : MeasurableSet E)
    (f : Lp ℂ 2 μ) :
    fibreEmb μ i (proj μ hE f) = proj μ hE (fibreEmb μ i f) := by sorry
