-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgSymbol_eq_metric_form
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgSymbol_eq_metric_form {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol xi xiY
      = ∑ i, ∑ j, qgMetric n i j * qgMomenta xi xiY i * qgMomenta xi xiY j := by sorry
