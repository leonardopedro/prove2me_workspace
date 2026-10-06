-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.Q_gf_anticomm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BRSTNilpotent_beta_move
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β) (hf12 : ∀ a b c, f a b c = -f b a c)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    Q f χ β * gfFermion β B + gfFermion β B * Q f χ β
      = ∑ a, ∑ b, ∑ c, (2 * f a b c) • (B a * (χ b * β c)) := by

  classical
  have hghost : ∀ a b c d : Fin n,
      (χ a * χ b * β c) * β d + β d * (χ a * χ b * β c)
        = (if d = a then χ b * β c else 0) - (if d = b then χ a * β c else 0) := by
    intro a b c d
    have hmove := beta_move χ β hCAR d a b
    have hbb : β c * β d + β d * β c = 0 := hCAR.betabeta c d
    have h1 : β d * (χ a * χ b * β c) = (β d * (χ a * χ b)) * β c := by noncomm_ring
    rw [h1, hmove]
    have h2 : (χ a * χ b * β c) * β d
        + ((if d = a then χ b else 0) - (if d = b then χ a else 0) + χ a * χ b * β d) * β c
        = ((if d = a then χ b else 0) - (if d = b then χ a else 0)) * β c
          + (χ a * χ b) * (β c * β d + β d * β c) := by noncomm_ring
    rw [h2, hbb, mul_zero, add_zero]
    by_cases hda : d = a <;> by_cases hdb : d = b <;>
      simp [hda, hdb, sub_mul]
  have hQ : Q f χ β * gfFermion β B + gfFermion β B * Q f χ β
      = ∑ a, ∑ b, ∑ c, ∑ d, f a b c •
          (B d * ((if d = a then χ b * β c else 0) - (if d = b then χ a * β c else 0))) := by
    unfold Q gfFermion
    have hLterm : ∀ a b c d : Fin n,
        (f a b c • (χ a * χ b * β c)) * (β d * B d)
          = f a b c • (B d * ((χ a * χ b * β c) * β d)) := by
      intro a b c d
      have hcomm : (χ a * χ b * β c) * (β d * B d) = B d * ((χ a * χ b * β c) * β d) := by
        rw [← hBβ d d, ← mul_assoc]
        have e1 : β c * B d = B d * β c := (hBβ d c).symm
        have e2 : χ b * B d = B d * χ b := (hBχ d b).symm
        have e3 : χ a * B d = B d * χ a := (hBχ d a).symm
        have hb1 : (χ a * χ b * β c) * B d = B d * (χ a * χ b * β c) := by
          calc (χ a * χ b * β c) * B d = (χ a * χ b) * (β c * B d) := by noncomm_ring
            _ = (χ a * χ b) * (B d * β c) := by rw [e1]
            _ = χ a * (χ b * B d) * β c := by noncomm_ring
            _ = χ a * (B d * χ b) * β c := by rw [e2]
            _ = (χ a * B d) * (χ b * β c) := by noncomm_ring
            _ = (B d * χ a) * (χ b * β c) := by rw [e3]
            _ = B d * (χ a * χ b * β c) := by noncomm_ring
        rw [hb1, mul_assoc]
      rw [smul_mul_assoc, hcomm]
    have hRterm : ∀ a b c d : Fin n,
        (β d * B d) * (f a b c • (χ a * χ b * β c))
          = f a b c • (B d * (β d * (χ a * χ b * β c))) := by
      intro a b c d
      rw [mul_smul_comm]
      congr 1
      rw [← mul_assoc, ← hBβ d d]
      simp only [mul_assoc]
    have hL : (∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * β c)) * (∑ d, β d * B d)
        = ∑ a, ∑ b, ∑ c, ∑ d, f a b c • (B d * ((χ a * χ b * β c) * β d)) := by
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun b _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun c _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun d _ => hLterm a b c d
    have hR : (∑ d, β d * B d) * (∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * β c))
        = ∑ a, ∑ b, ∑ c, ∑ d, f a b c • (B d * (β d * (χ a * χ b * β c))) := by
      rw [Finset.sum_mul]
      have hstep : ∀ d : Fin n, (β d * B d) * (∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * β c))
          = ∑ a, ∑ b, ∑ c, f a b c • (B d * (β d * (χ a * χ b * β c))) := by
        intro d
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun b _ => ?_
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun c _ => hRterm a b c d
      rw [Finset.sum_congr rfl fun d _ => hstep d]
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun b _ => ?_
      exact Finset.sum_comm
    rw [hL, hR, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [← smul_add, ← mul_add, hghost a b c d]
  rw [hQ]
  have hd : ∀ a b c : Fin n,
      (∑ d, f a b c • (B d * ((if d = a then χ b * β c else 0)
        - (if d = b then χ a * β c else 0))))
        = f a b c • (B a * (χ b * β c)) - f a b c • (B b * (χ a * β c)) := by
    intro a b c
    have hsplit : ∀ d : Fin n, f a b c • (B d * ((if d = a then χ b * β c else 0)
        - (if d = b then χ a * β c else 0)))
          = (if d = a then f a b c • (B a * (χ b * β c)) else 0)
            - (if d = b then f a b c • (B b * (χ a * β c)) else 0) := by
      intro d
      by_cases h1 : d = a
      · subst h1
        by_cases h2 : d = b
        · subst h2
          simp
        · simp [h2]
      · by_cases h2 : d = b
        · subst h2
          simp [h1]
        · simp [h1, h2]
    rw [Finset.sum_congr rfl fun d _ => hsplit d, Finset.sum_sub_distrib]
    simp
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => hd a b c]
  -- the second family of terms is the first one again, by antisymmetry of `f`
  have hswap : (∑ a, ∑ b, ∑ c, f a b c • (B b * (χ a * β c)))
      = -∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)) := by
    rw [Finset.sum_comm]
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [hf12 b a c]
    simp
  have hsplit2 : (∑ a, ∑ b, ∑ c, (f a b c • (B a * (χ b * β c))
      - f a b c • (B b * (χ a * β c))))
      = (∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)))
        - ∑ a, ∑ b, ∑ c, f a b c • (B b * (χ a * β c)) := by
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_sub_distrib]
  rw [hsplit2, hswap, sub_neg_eq_add]
  have hdouble : (∑ a, ∑ b, ∑ c, (2 * f a b c) • (B a * (χ b * β c)))
      = (∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)))
        + ∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [two_mul, add_smul]
  rw [hdouble]
