-- Generated from ChapterA4h.lean — theorem BookProof.ChapterA4h.prop87_assembled
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4h
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterWeylCauchyRiemann
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.WeylCauchyRiemann
open BookProof.ChapterA4h

variable (R : Type*)


open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

theorem BookProof.ChapterA4h.prop87_assembled (Mk : MackeyImprimitivity R)
    (Wg : WignerClassification R Mk) (ρ : R) :
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.massive ∨
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.masslessDiscrete := by sorry
