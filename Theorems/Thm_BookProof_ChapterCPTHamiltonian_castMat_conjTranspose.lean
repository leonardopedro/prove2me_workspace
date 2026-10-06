-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.castMat_conjTranspose
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.castMat_conjTranspose (M : Matrix (Fin 4) (Fin 4) ℤ) :
    ((Int.castRingHom ℂ).mapMatrix M)ᴴ = (Int.castRingHom ℂ).mapMatrix Mᵀ := by sorry
