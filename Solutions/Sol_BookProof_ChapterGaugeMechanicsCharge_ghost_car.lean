-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.ghost_car
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution :
    ChapterG.ghostAnnih (A := Module.End ℂ P) * ChapterG.ghostCreat
      + ChapterG.ghostCreat * ChapterG.ghostAnnih = 1 := ChapterG.ghost_car
