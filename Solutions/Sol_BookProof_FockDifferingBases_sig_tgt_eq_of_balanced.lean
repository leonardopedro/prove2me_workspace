-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.sig_tgt_eq_of_balanced
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockQuadratic_sig_tgt
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic
open BookProof.ChapterA3n

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {P Q : Idx ι} (h : Balanced ω P Q) {b : Idx ι} (hb : P ≤ b) :
    sig ω (tgt P Q b) = sig ω b := by

  rw [sig_tgt hb]
  unfold Balanced at h
  linarith
