-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.christoffel_eq_zero_of_const
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.christoffel_eq_zero_of_const {m : ℕ} (g0 : Matrix (Fin m) (Fin m) ℝ)
    (ginv : EuclideanSpace ℝ (Fin m) → Matrix (Fin m) (Fin m) ℝ)
    (q : EuclideanSpace ℝ (Fin m)) (k i j : Fin m) :
    christoffel (fun _ => g0) ginv q k i j = 0 := by sorry
