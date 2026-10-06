-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.potMomOp_symmetric
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_opL2_add
import Theorems.Thm_BookProof_FourierMultiplierEsa_fourier_momentumOp_apply
import Theorems.Thm_BookProof_FourierMultiplierEsa_symmetricOn_of_real_symbol
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (W : V → ℝ) (hW : Function.HasTemperateGrowth W) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp W m)) := by

  have hmom : SymmetricOn (schwartzDomain V) (opL2 (momentumOp m)) :=
    symmetricOn_of_real_symbol (momentumOp m) (fun x => 2 * Real.pi * (inner ℝ x m))
      (fun f x => by simpa using fourier_momentumOp_apply f m x)
  rw [potMomOp, opL2_add]
  intro x y
  simp only [LinearMap.add_apply, inner_add_left, inner_add_right,
    potentialOp_symmetric W hW x y, hmom x y]
