-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.norm_coreExt_le
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
open BookProof.CoreBounds




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

variable {ι : Type*} {c : ι → ℝ}
variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι} {A : ℝ}
    (hA : CoreRelBound c H₀ A) (x : maxDom c) :
    ‖coreExt hA x‖ ≤ A * ‖(diagMax c x : L2I ι)‖ := by

  have h1 : Tendsto (fun S : Finset ι => ‖H₀ (trunc c x S)‖) atTop (𝓝 ‖coreExt hA x‖) :=
    (tendsto_coreExt hA x).norm
  have h2 : Tendsto (fun S : Finset ι =>
      A * ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)‖) atTop
      (𝓝 (A * ‖(diagMax c x : L2I ι)‖)) := ((tendsto_diag_trunc c x).norm).const_mul A
  exact le_of_tendsto_of_tendsto' h1 h2 fun S => hA _
