-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.qg3D_deficiencyTrivialAt
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.qg3D_deficiencyTrivialAt (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) {z : ℂ}
    (hz : z.im ≠ 0) :
    DeficiencyTrivialAt hermiteCore (qg3DHermiteHamiltonian xi xiY V) z := by sorry
