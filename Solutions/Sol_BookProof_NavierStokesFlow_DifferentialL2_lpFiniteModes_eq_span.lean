-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.lpFiniteModes_eq_span
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
s_apply]

theorem solution (b : Vel) :
    ((coreState b : lpFiniteModes Vel) : L2I Vel) = lp.single 2 b (1 : ℂ) := rfl

/-- The finite-mode core of `ℓ²(Vel) :=
  ` is the algebraic span of the basis states. -/
  theorem lpFiniteModes_eq_span :
      lpFiniteModes Vel
        = Submodule.span ℂ (Set.range fun b : Vel => (lp.single 2 b (1 : ℂ) : L2I Vel)) := by
    classical
    refine le_antisymm (fun f hf => ?_) ?_
    · have hfin : (Function.support ((f : Vel → ℂ))).Finite := hf
      have hsum : f = ∑ b ∈ hfin.toFinset, ((f : Vel → ℂ) b) • (lp.single 2 b (1 : ℂ)) := by
        refine lp.ext (funext fun j => ?_)
        rw [lp.coeFn_sum]
        simp only [Finset.sum_apply, lp.coeFn_smul, Pi.smul_apply, lp.single_apply,
          Pi.single_apply, smul_eq_mul, mul_ite, mul_one, mul_zero]
        rw [Finset.sum_ite_eq hfin.toFinset j (fun b => (f : Vel → ℂ) b)]
        by_cases hj : j ∈ hfin.toFinset
        · rw [if_pos hj]
        · rw [if_neg hj]
          have : j ∉ Function.support ((f : Vel → ℂ)) := by
            simpa [Set.Finite.mem_toFinset] using hj
          simpa [Function.mem_support] using this
      rw [hsum]
      exact
