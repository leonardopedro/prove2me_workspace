-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.laplacian_angular_mul
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Theorems.Thm_BookProof_ChapterLaplacianProduct_laplacian_mul
import Theorems.Thm_BookProof_ChapterLaplacianProduct_sum_inner_mul_apply
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {A B : E → ℝ} {x : E} {α β : ℝ} {e : E} {μ : ℕ}
    (hA : ContDiffAt ℝ 2 A x) (hB : ContDiffAt ℝ 2 B x)
    (hharm : (Δ A) x = 0) (heuler : fderiv ℝ A x x = μ * A x) (haxis : fderiv ℝ A x e = 0)
    (hgrad : fderiv ℝ B x = α • innerCLM E e + β • innerCLM E x) :
    (Δ fun y : E => A y * B y) x = A x * (Δ B) x + 2 * β * (μ : ℝ) * A x := by

  have hprod := laplacian_mul hA hB
  have hcross : ∑ i, fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i)
      * fderiv ℝ B x ((stdOrthonormalBasis ℝ E) i)
      = α * fderiv ℝ A x e + β * fderiv ℝ A x x := by
    have he' : ∑ i, ⟪e, (stdOrthonormalBasis ℝ E) i⟫_ℝ
        * fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i) = fderiv ℝ A x e :=
      sum_inner_mul_apply (fderiv ℝ A x) e
    have hx' : ∑ i, ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
        * fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i) = fderiv ℝ A x x :=
      sum_inner_mul_apply (fderiv ℝ A x) x
    have hterm : ∀ i, fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i)
        * fderiv ℝ B x ((stdOrthonormalBasis ℝ E) i)
        = α * (⟪e, (stdOrthonormalBasis ℝ E) i⟫_ℝ * fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i))
          + β * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
            * fderiv ℝ A x ((stdOrthonormalBasis ℝ E) i)) := by
      intro i
      rw [hgrad]
      simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.coe_smul', Pi.smul_apply,
        smul_eq_mul, innerCLM_apply]
      ring
    simp only [hterm]
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, he', hx']
  rw [hprod, hcross, hharm, haxis, heuler]
  ring
