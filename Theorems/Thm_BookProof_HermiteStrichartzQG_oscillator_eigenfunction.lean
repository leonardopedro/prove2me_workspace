-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.oscillator_eigenfunction
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HermiteStrichartzQG



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.oscillator_eigenfunction (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x
      = oscillatorSymbol n * hermiteFun n x := by sorry
