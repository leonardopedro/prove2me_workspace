-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.coreExt_symmetricOn
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Theorems.Thm_BookProof_CoreBounds_tendsto_trunc
open BookProof.CoreBounds




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

variable {ι : Type*} {c : ι → ℝ}
variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι}
    {A : ℝ} (hA : CoreRelBound c H₀ A)
    (hsym : ∀ u v : lpFiniteModes ι,
      (inner ℂ (H₀ u) ((v : L2I ι)) : ℂ) = inner ℂ ((u : L2I ι)) (H₀ v)) :
    SymmetricOn (maxDom c) (coreExt hA) := by

  intro x y
  have hL : Tendsto (fun S : Finset ι =>
      (inner ℂ (H₀ (trunc c x S)) ((trunc c y S : lpFiniteModes ι) : L2I ι) : ℂ)) atTop
      (𝓝 (inner ℂ (coreExt hA x) ((y : L2I ι)) : ℂ)) :=
    ((tendsto_coreExt hA x).inner (tendsto_trunc c y))
  have hR : Tendsto (fun S : Finset ι =>
      (inner ℂ ((trunc c x S : lpFiniteModes ι) : L2I ι) (H₀ (trunc c y S)) : ℂ)) atTop
      (𝓝 (inner ℂ ((x : L2I ι)) (coreExt hA y) : ℂ)) :=
    ((tendsto_trunc c x).inner (tendsto_coreExt hA y))
  refine tendsto_nhds_unique hL (hR.congr fun S => ?_)
  exact (hsym (trunc c x S) (trunc c y S)).symm
