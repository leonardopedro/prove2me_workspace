-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.brstCharge_gf_anticomm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_glin_gf_anticomm
import Theorems.Thm_BookProof_BookBrstGaugeFixing_Q_gf_anticomm
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β) (hf12 : ∀ a b c, f a b c = -f b a c)
    (hGβ : ∀ a b, Gc a * β b = β b * Gc a)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    brstCharge f Gc χ β * gfFermion β B + gfFermion β B * brstCharge f Gc χ β
      = (∑ c, Gc c * B c)
        - (∑ c, ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c))
        - ∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)) := by

  have h1 := glin_gf_anticomm hCAR hGβ hBχ hBβ
  have h2 := Q_gf_anticomm (B := B) hCAR hf12 hBχ hBβ
  have hexp : brstCharge f Gc χ β * gfFermion β B + gfFermion β B * brstCharge f Gc χ β
      = (glin Gc χ * gfFermion β B + gfFermion β B * glin Gc χ)
        - (1 / 2 : ℝ) • (Q f χ β * gfFermion β B + gfFermion β B * Q f χ β) := by
    rw [brstCharge, sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_add]
    abel
  rw [hexp, h1, h2]
  have hhalf : (1 / 2 : ℝ) • (∑ a, ∑ b, ∑ c, (2 * f a b c) • (B a * (χ b * β c)))
      = ∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)) := by
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [smul_smul]
    congr 1
    ring
  rw [hhalf, sub_sub]
