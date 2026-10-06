-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.Kin_eq_cast
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.Kin_eq_cast (j : Fin 3) :
    Kin j = (Int.castRingHom ℂ).mapMatrix (KinZ j) := by sorry
