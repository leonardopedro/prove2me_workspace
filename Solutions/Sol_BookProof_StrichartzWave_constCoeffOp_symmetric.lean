-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.constCoeffOp_symmetric
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Theorems.Thm_BookProof_StrichartzWave_fourier_constCoeffOp_apply
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_eq_integral_fourier
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (constCoeffOp c w κ)) :=
  ℝ) (w : ι → V) (κ : ℝ) :
      BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (constCoeffOp c w κ)) := by
    intro x y
    obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
    obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
    rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
      inner_toLp_eq_integral_fourier, inner_toLp_eq_integral_fourier]
    refine integral_congr_ae (F
