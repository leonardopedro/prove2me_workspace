-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.pauli_commutator
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.pauli_commutator (k l : Fin 3) :
    pauliV k * pauliV l - pauliV l * pauliV k = (2 * Complex.I) • ∑ m, eps k l m • pauliV m := by sorry
