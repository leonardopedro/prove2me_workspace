-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgMetric_det
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgMetric_det (n : ℕ) :
    (qgMetric n).det = ∏ i, (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ) := by sorry
