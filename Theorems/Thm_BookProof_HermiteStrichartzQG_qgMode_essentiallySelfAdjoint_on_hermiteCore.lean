-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.qgMode_essentiallySelfAdjoint_on_hermiteCore
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterA4
open BookProof.QuantumGravityDensitized
open BookProof.HermiteStrichartzQG



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.qgMode_essentiallySelfAdjoint_on_hermiteCore (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp (qgModeSymbol a b V)) := by sorry
