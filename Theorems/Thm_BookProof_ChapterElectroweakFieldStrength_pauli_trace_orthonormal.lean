-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.pauli_trace_orthonormal
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.pauli_trace_orthonormal (a b : Fin 3) :
    (pauliV a * pauliV b).trace = 2 * (if a = b then 1 else 0) := by sorry
