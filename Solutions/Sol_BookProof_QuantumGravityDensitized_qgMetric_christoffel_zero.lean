-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgMetric_christoffel_zero
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_christoffel_eq_zero_of_const
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ}
    (ginv : EuclideanSpace ℝ (Fin (n + 1)) → Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ)
    (q : EuclideanSpace ℝ (Fin (n + 1))) (k i j : Fin (n + 1)) :
    christoffel (fun _ => qgMetric n) ginv q k i j = 0 := christoffel_eq_zero_of_const _ ginv q k i j
