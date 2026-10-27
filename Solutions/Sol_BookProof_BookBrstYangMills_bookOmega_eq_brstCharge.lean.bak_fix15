-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bookOmega_eq_brstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_rsmul_eq_csmul
import Theorems.Thm_BookProof_BookBrstYangMills_I_smul_gaussGen
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution :
    bookOmega G = Complex.I • brstCharge G.f (gaussGen G) chiOp betaOp := by

  have hglin : Complex.I • glin (gaussGen G) chiOp
      = (∑ μ, ∑ a, mom μ a * dChi G μ a)
        - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c)) := by
    have h1 : Complex.I • glin (gaussGen G) chiOp
        = ∑ c, (Complex.I • gaussGen G c) * chiOp c := by
      rw [glin, Finset.smul_sum]
      exact Finset.sum_congr rfl fun c _ => (smul_mul_assoc _ _ _).symm
    rw [h1]
    have h2 : ∀ c : Fin N, (Complex.I • gaussGen G c) * chiOp c
        = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
          - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c)) := by
      intro c
      rw [I_smul_gaussGen, sub_mul]
      congr 1
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun a _ => smul_mul_assoc _ _ _
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun b _ => smul_mul_assoc _ _ _
    rw [Finset.sum_congr rfl fun c _ => h2 c, Finset.sum_sub_distrib]
    congr 1
    · -- the derivative term
      have hT1 : (∑ μ, ∑ a, mom μ a * dChi G μ a)
          = ∑ μ, ∑ a, ∑ c, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c) := by
        refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => ?_
        rw [dChi, Finset.mul_sum]
        refine Finset.sum_congr rfl fun c _ => ?_
        rw [rsmul_eq_csmul, mul_smul_comm]
      rw [hT1]
      rw [Finset.sum_comm (f := fun c μ => ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      exact Finset.sum_comm (f := fun c a => ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
    · -- the cubic-in-fields term
      have hT2 : (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c))
          = ∑ μ, ∑ a, ∑ b, ∑ c, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c) := by
        refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ =>
          Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => ?_
        rw [rsmul_eq_csmul]
      rw [hT2]
      rw [Finset.sum_comm (f := fun c μ => ∑ a, ∑ b,
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [Finset.sum_comm (f := fun c a => ∑ b,
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))]
      refine Finset.sum_congr rfl fun a _ => ?_
      exact Finset.sum_comm (f := fun c b =>
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))
  have hQ : Complex.I • ((1 / 2 : ℝ) • Q G.f (chiOp (N := N)) betaOp)
      = (Complex.I / 2) • (∑ a, ∑ b, ∑ c, (G.f a b c) • (chiOp a * chiOp b * betaOp c)) := by
    rw [Q, rsmul_eq_csmul, smul_smul]
    congr 1
    push_cast
    ring
  rw [bookOmega, brstCharge, smul_sub, hglin, hQ]
