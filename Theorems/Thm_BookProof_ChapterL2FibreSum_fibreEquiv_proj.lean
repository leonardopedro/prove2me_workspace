-- Generated from ChapterL2FibreSum.lean — theorem BookProof.ChapterL2FibreSum.fibreEquiv_proj
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterA4
open BookProof.ChapterElectroweakFieldStrength

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]


open MeasureTheory
open scoped InnerProductSpace




theorem BookProof.ChapterL2FibreSum.fibreEquiv_proj [Countable ι] (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (v : Lp (Fibre ι) 2 μ) (i : ι) :
    fibreEquiv μ (proj μ hE v) i = proj μ hE (fibreEquiv μ v i) := by sorry
