-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.Rpseudoreal_realCommutant_eq_quaternion
import Mathlib
import Definitions.Def_ChapterA2c
import Theorems.Thm_BookProof_ChapterA_realCommutes_mul
import Theorems.Thm_BookProof_ChapterA_realCommutes_thetaR
import Theorems.Thm_BookProof_ChapterA_qembed_realCommutes
import Theorems.Thm_BookProof_ChapterA_cplxify_commutes
import Theorems.Thm_BookProof_ChapterA_Plin_add_Qanti
import Theorems.Thm_BookProof_ChapterA_Plin_commutes_mulI
import Theorems.Thm_BookProof_ChapterA_Qanti_anticommutes_mulI
import Theorems.Thm_BookProof_ChapterA_Plin_realCommutes
import Theorems.Thm_BookProof_ChapterA_Qanti_realCommutes
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (hSchur : IsSchurFull M)
    {θ : AntiUnitary V} (hθ : ∀ x, θ (θ x) = -x) (hθc : CommutesAntiUnitary M θ)
    (S : V →L[ℝ] V) :
    RealCommutes M S ↔ ∃ q : Quaternion ℝ, S = qembed θ hθ q := by

  have key : ∀ (a : ℂ) (v : V), a • v = a.re • v + a.im • (Complex.I • v) := by
    intro a v
    rw [← Complex.coe_smul, ← Complex.coe_smul, smul_smul, ← add_smul, Complex.re_add_im]
  constructor
  · intro hS
    -- Complex-linear part `Plin S` is a complex scalar `c`.
    have hP := Plin_commutes_mulI S
    obtain ⟨c, hc⟩ := hSchur _ (cplxify_commutes hP (Plin_realCommutes hS))
    have hPeq : ∀ x, Plin S x = c • x := by
      intro x
      have hx : cplxify (Plin S) hP x = (c • (1 : V →L[ℂ] V)) x := by rw [hc]
      simpa using hx
    -- `W := Qanti S ∘ θ` is complex-linear (antilinear ∘ antilinear).
    have hQanti := Qanti_anticommutes_mulI S
    have hWlin : ∀ x, (Qanti S * thetaR θ) (Complex.I • x)
        = Complex.I • (Qanti S * thetaR θ) x := by
      intro x
      simp only [ContinuousLinearMap.mul_apply, thetaR_apply]
      have hθI : θ (Complex.I • x) = -(Complex.I • θ x) := by
        rw [θ.map_smulₛₗ]; simp
      rw [hθI, map_neg, hQanti (θ x), neg_neg]
    have hWc : RealCommutes M (Qanti S * thetaR θ) :=
      realCommutes_mul (Qanti_realCommutes hS) (realCommutes_thetaR hθc)
    obtain ⟨d', hd'⟩ := hSchur _ (cplxify_commutes hWlin hWc)
    have hWeq : ∀ x, Qanti S (θ x) = d' • x := by
      intro x
      have hx : cplxify (Qanti S * thetaR θ) hWlin x = (d' • (1 : V →L[ℂ] V)) x := by
        rw [hd']
      simpa [ContinuousLinearMap.mul_apply, thetaR_apply] using hx
    -- Hence `Qanti S y = (-d') • θ y`.
    have hQeq : ∀ y, Qanti S y = (-d') • θ y := by
      intro y
      have hsym : θ (θ.symm y) = y := θ.apply_symm_apply y
      have hy : θ.symm y = -θ y := by
        apply θ.injective
        rw [hsym, map_neg, hθ, neg_neg]
      have hz := hWeq (θ.symm y)
      rw [hsym] at hz
      rw [hz, hy, smul_neg, neg_smul]
    -- Assemble `S = c·1 + (-d')·θ = qembed ⟨c.re, c.im, (-d').re, (-d').im⟩`.
    refine ⟨(@id (Quaternion ℝ) ⟨c.re, c.im, (-d').re, (-d').im⟩), ?_⟩
    ext x
    have hSx : S x = c • x + (-d') • θ x := by
      have h1 : S x = Plin S x + Qanti S x := by
        conv_lhs => rw [← Plin_add_Qanti S]
        simp [ContinuousLinearMap.add_apply]
      rw [h1, hPeq x, hQeq x]
    rw [hSx]
    simp only [qembed_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
      Algebra.algebraMap_eq_smul_one, ContinuousLinearMap.one_apply, mulI_apply,
      ContinuousLinearMap.mul_apply, thetaR_apply]
    rw [key c x, key (-d') (θ x)]
    abel
  · rintro ⟨q, rfl⟩
    exact qembed_realCommutes hθ hθc q
