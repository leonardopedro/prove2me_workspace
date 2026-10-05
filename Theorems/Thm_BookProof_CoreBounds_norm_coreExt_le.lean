-- Generated from ChapterCoreBoundsEsa.lean — theorem BookProof.CoreBounds.norm_coreExt_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
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


theorem BookProof.CoreBounds.norm_coreExt_le [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι} {A : ℝ}
    (hA : CoreRelBound c H₀ A) (x : maxDom c) :
    ‖coreExt hA x‖ ≤ A * ‖(diagMax c x : L2I ι)‖ := by sorry
