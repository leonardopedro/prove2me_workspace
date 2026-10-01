-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgMomenta_castSucc
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgMomenta_castSucc {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) (a : Fin n) :
    qgMomenta xi xiY a.castSucc = xi a := by sorry
