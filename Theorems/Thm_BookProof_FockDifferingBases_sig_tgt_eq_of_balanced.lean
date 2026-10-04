-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.sig_tgt_eq_of_balanced
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA4
open BookProof.ChapterA3n
open BookProof.FockDifferingBases

variable {ι κ : Type*} {ω : ι → ℝ}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section


theorem BookProof.FockDifferingBases.sig_tgt_eq_of_balanced {P Q : Idx ι} (h : Balanced ω P Q) {b : Idx ι} (hb : P ≤ b) :
    sig ω (tgt P Q b) = sig ω b := by sorry
