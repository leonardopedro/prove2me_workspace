-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.antihermPart_isHermitian
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (X : Matrix n n ℂ) : (antihermPart X).IsHermitian := by

  unfold Matrix.IsHermitian antihermPart
  rw [conjTranspose_smul, conjTranspose_sub, conjTranspose_conjTranspose,
      show (Xᴴ - X) = (-1 : ℂ) • (X - Xᴴ) by module, smul_smul]
  congr 1
  rw [star_inv₀]
  simp only [star_mul', Complex.star_def, map_ofNat, Complex.conj_I]
  have : (2 * Complex.I) ≠ 0 := by simp [Complex.I_ne_zero]
  field_simp
