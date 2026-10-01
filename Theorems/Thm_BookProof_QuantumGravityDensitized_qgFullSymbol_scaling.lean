-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgFullSymbol_scaling
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgFullSymbol_scaling {n : ℕ} (c : ℝ) (xi : Fin n → ℝ) (xiY : ℝ)
    (b : Fin n → ℝ) (bY : ℝ) (V : ℝ) :
    qgFullSymbol (fun a => c * xi a) (c * xiY) b bY V
      = c ^ 2 * qgSymbol xi xiY + c * ((∑ a, b a * xi a) + bY * xiY) - V := by sorry
