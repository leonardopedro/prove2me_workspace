import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib

/-!
# The closure of an essentially self-adjoint operator: the Hashimoto/SIRK consequence

The abstract theory — the graph `opGraph`, its closure `clGraph`, the closed
extension `clExt`, the self-adjointness criterion and the Cayley transform —
lives in `BookProof.ChapterEsaClosureCore`, which depends only on
`BookProof.ChapterFarisLavineCore` and Mathlib.  This module adds the part that
talks to the Hashimoto/SIRK shift-invert algorithm of
`BookProof.ChapterHashimotoComplexShifts`.
-/
namespace BookProof.EsaClosure

end BookProof.EsaClosure
