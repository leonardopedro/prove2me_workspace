-- Generated from ChapterWignerLittleGroupOrbits.lean — solution of BookProof.ChapterWignerLittleGroupOrbits.posSemidef_diag2
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
open BookProof.ChapterWignerLittleGroupOrbits



open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

set_option maxHeartbeats 1000000 in
theorem solution {c d : ℝ} (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (!![(c : ℂ), 0; 0, (d : ℂ)]).PosSemidef := by

  have hdiag : !![(c : ℂ), 0; 0, (d : ℂ)] = Matrix.diagonal ![(c : ℂ), (d : ℂ)] := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp [Matrix.diagonal]
  rw [hdiag, Matrix.posSemidef_diagonal_iff]
  intro i
  fin_cases i
  · simpa using Complex.zero_le_real.mpr hc
  · simpa using Complex.zero_le_real.mpr hd
