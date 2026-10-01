-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.mulHamiltonian_not_bounded
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

set_option maxHeartbeats 1000000 in
) : ℕ → ℂ)) 2
    rw [hval]
    exact (lp.memℓp _).const_smul _⟩

theorem solution (lam : ℕ → ℝ) (hlam : ∀ C : ℝ, ∃ n, C < |lam n|) :
    ¬ ∃ C : ℝ, ∀ f :=
  : mulSymbolDomain lam, ‖mulHamiltonian lam f‖ ≤ C * ‖(f : L2Nat)‖ := by
    rintro ⟨C, hC⟩
    obtain ⟨n, hn⟩ := hlam C
    have hb := hC (mulBasis lam n)
    have hval : (mulHamiltonian lam (mulBasis lam n) : L2Nat)
        = (lam n : ℂ) • lp.single 2 n (1 : ℂ) := by
      ext m
      simp only [mulHamiltonian, mulBasis, mulSymbolOp, mulSymbolFun, lp.single_apply]
      simp only [lp.coeFn_smul]
      by_cases hmn : m = n
      · subst hmn
        simp [mulSymbolFun, lp.single_apply]
      · simp [mulSymbolFun, lp.single_apply, hmn]
    have hnorm : ‖(lp.single 2 n (1 : ℂ) : L2Nat)‖ = 1 := by
      simp
    rw [hval, norm_smul] at hb
    have hb' : |lam n| ≤ C := by
      have hcoe : ‖(m
