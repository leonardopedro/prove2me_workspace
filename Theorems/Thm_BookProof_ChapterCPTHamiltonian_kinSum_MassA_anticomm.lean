-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.kinSum_MassA_anticomm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.kinSum_MassA_anticomm (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j) * MassA + MassA * (∑ j : Fin 3, (k j : ℂ) • Kin j)
      = 0 := by sorry
