-- Generated from ChapterElectroweakFieldStrength.lean — solution of BookProof.ChapterElectroweakFieldStrength.pauli_commutator
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength



open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution (k l : Fin 3) :
    pauliV k * pauliV l - pauliV l * pauliV k = (2 * Complex.I) • ∑ m, eps k l m • pauliV m := by

  fin_cases k <;> fin_cases l <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliV, pauli1, pauli2, pauli3, eps,
          Matrix.smul_apply, Complex.ext_iff] <;> norm_num
