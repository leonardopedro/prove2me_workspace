-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.coreExt_core
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
    (hA : CoreRelBound c H₀ A) (u : lpFiniteModes ι) :
    coreExtFun c H₀ (inclC c u) = H₀ u := by

  classical
  have hfin : (Function.support ((u : L2I ι) : ι → ℂ)).Finite := u.2
  have heq : ∀ S : Finset ι, hfin.toFinset ⊆ S → trunc c (inclC c u) S = u := by
    intro S hS
    ext k
    rw [trunc_coe]
    by_cases hk : k ∈ S
    · simp [hk]
    · have : ((u : L2I ι) : ι → ℂ) k = 0 := by
        by_contra hne
        exact hk (hS (by simpa [Set.Finite.mem_toFinset, Function.mem_support] using hne))
      simp [hk, this]
  have : Tendsto (fun S : Finset ι => H₀ (trunc c (inclC c u) S)) atTop (𝓝 (H₀ u)) := by
    refine Tendsto.congr' ?_ tendsto_const_nhds
    filter_upwards [Filter.eventually_ge_atTop hfin.toFinset] with S hS
    rw [heq S hS]
  exact tendsto_nhds_unique (tendsto_coreExt hA (inclC c u)) this
