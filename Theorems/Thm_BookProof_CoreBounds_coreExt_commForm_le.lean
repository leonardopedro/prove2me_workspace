-- Generated from ChapterCoreBoundsEsa.lean — theorem BookProof.CoreBounds.coreExt_commForm_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.CoreBounds

variable {ι : Type*} {c : ι → ℝ}
variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section


theorem BookProof.CoreBounds.coreExt_commForm_le [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι}
    {A B : ℝ} (hA : CoreRelBound c H₀ A)
    (hcomm : ∀ u : lpFiniteModes ι,
      |(-2 : ℝ) * (inner ℂ (H₀ u) ((diagMax c (inclC c u) : L2I ι)) : ℂ).im|
        ≤ B * (inner ℂ ((u : L2I ι)) ((diagMax c (inclC c u) : L2I ι)) : ℂ).re)
    (x : maxDom c) :
    |commForm (coreExt hA) (diagMax c) x| ≤ B * quadForm (diagMax c) x := by sorry
