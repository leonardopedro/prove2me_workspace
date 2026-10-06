-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.kinSum_conjTranspose
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.kinSum_conjTranspose (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j)ᴴ = ∑ j : Fin 3, (k j : ℂ) • Kin j := by sorry
