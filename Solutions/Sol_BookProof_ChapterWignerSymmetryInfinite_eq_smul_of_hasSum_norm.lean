-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.eq_smul_of_hasSum_norm
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}

set_option maxHeartbeats 1000000 in
theorem solution {z : ι → ℂ} {S : ℂ} (hz : HasSum z S)
    (hn : HasSum (fun k => ‖z k‖) ‖S‖) (hS : S ≠ 0) (k : ι) :
    z k = (S / (‖S‖ : ℂ)) * ((‖z k‖ : ℝ) : ℂ) := by

  have hSpos : (0 : ℝ) < ‖S‖ := norm_pos_iff.2 hS
  have hSC : ((‖S‖ : ℝ) : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hSpos
  set w : ℂ := conj S / ((‖S‖ : ℝ) : ℂ) with hw
  have hwnorm : ‖w‖ = 1 := by
    rw [hw, norm_div, Complex.norm_conj, Complex.norm_real, Real.norm_of_nonneg hSpos.le,
      div_self (ne_of_gt hSpos)]
  have hnormSq : conj S * S = ((‖S‖ ^ 2 : ℝ) : ℂ) := by
    rw [mul_comm, Complex.mul_conj, Complex.sq_norm]
  have hwS : w * S = ((‖S‖ : ℝ) : ℂ) := by
    rw [hw, div_mul_eq_mul_div, hnormSq]
    push_cast
    field_simp
  have hmul : HasSum (fun k => w * z k) (((‖S‖ : ℝ) : ℂ)) := by
    have := hz.mul_left w
    rwa [hwS] at this
  have hre : HasSum (fun k => (w * z k).re) ‖S‖ := by
    have h := hmul.mapL Complex.reCLM
    simpa using h
  have hle : ∀ k, (w * z k).re ≤ ‖z k‖ := by
    intro k
    calc (w * z k).re ≤ ‖w * z k‖ := Complex.re_le_norm _
      _ = ‖z k‖ := by rw [norm_mul, hwnorm, one_mul]
  have hdiff : HasSum (fun k => ‖z k‖ - (w * z k).re) 0 := by
    have := hn.sub hre
    simpa using this
  have hzero : (fun k => ‖z k‖ - (w * z k).re) = 0 :=
    (hasSum_zero_iff_of_nonneg (fun k => by linarith [hle k])).1 hdiff
  have hk : (w * z k).re = ‖z k‖ := by
    have := congrFun hzero k
    simp only [Pi.zero_apply] at this
    linarith
  have hnormwz : ‖w * z k‖ = ‖z k‖ := by rw [norm_mul, hwnorm, one_mul]
  have hreal : w * z k = ((‖z k‖ : ℝ) : ℂ) := by
    have := eq_norm_of_re_eq_norm (z := w * z k) (by rw [hk, hnormwz])
    rw [this, hnormwz]
  have hinv : (S / ((‖S‖ : ℝ) : ℂ)) * w = 1 := by
    have h1 : (S / ((‖S‖ : ℝ) : ℂ)) * w = (conj S * S) / ((‖S‖ : ℝ) : ℂ) ^ 2 := by
      rw [hw]
      field_simp
    rw [h1, hnormSq]
    push_cast
    field_simp
  calc z k = ((S / ((‖S‖ : ℝ) : ℂ)) * w) * z k := by rw [hinv]; ring
    _ = (S / ((‖S‖ : ℝ) : ℂ)) * (w * z k) := by ring
    _ = (S / ((‖S‖ : ℝ) : ℂ)) * ((‖z k‖ : ℝ) : ℂ) := by rw [hreal]
