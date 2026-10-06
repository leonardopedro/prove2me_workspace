-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.pauli_triple_trace
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.pauli_triple_trace (a b c : Fin 3) :
    (pauliV a * pauliV b * pauliV c).trace = 2 * Complex.I * eps a b c := by sorry
