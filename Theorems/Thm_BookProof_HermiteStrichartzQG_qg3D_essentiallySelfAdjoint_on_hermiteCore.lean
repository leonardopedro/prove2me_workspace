-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.qg3D_essentiallySelfAdjoint_on_hermiteCore
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HermiteStrichartzQG



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.qg3D_essentiallySelfAdjoint_on_hermiteCore (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (qg3DHermiteHamiltonian xi xiY V) := by sorry
