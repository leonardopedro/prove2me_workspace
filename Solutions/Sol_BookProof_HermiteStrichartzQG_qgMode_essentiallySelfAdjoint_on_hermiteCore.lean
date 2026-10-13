-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.qgMode_essentiallySelfAdjoint_on_hermiteCore
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_essentiallySelfAdjoint
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp (qgModeSymbol a b V)) := hermiteCoreOp_essentiallySelfAdjoint _
