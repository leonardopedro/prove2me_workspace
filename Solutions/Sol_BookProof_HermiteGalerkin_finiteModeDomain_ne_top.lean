-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.finiteModeDomain_ne_top
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]










variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]







open scoped InnerProductSpace ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : finiteModeDomain ell2Basis ≠ ⊤ := by

  set x : ℓ²(ℕ, ℂ) := ⟨fun n : ℕ => (1 / (n + 1) : ℂ), memℓp_one_div_succ⟩ with hx
  have hcoeff : ∀ i, ell2Basis.repr x i ≠ 0 := by
    intro i
    have hxi : (ell2Basis.repr x : ℕ → ℂ) i = 1 / ((i : ℂ) + 1) := rfl
    rw [hxi]
    have hne : ((i : ℂ) + 1) ≠ 0 := by
      rw [show ((i : ℂ) + 1) = (((i + 1 : ℕ) : ℂ)) by push_cast; ring]
      exact_mod_cast Nat.succ_ne_zero i
    simpa using hne
  have hnot : x ∉ finiteModeDomain ell2Basis :=
    not_mem_span_of_repr_ne_zero ell2Basis x hcoeff
  intro htop
  exact hnot (by rw [htop]; trivial)
