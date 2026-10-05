-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.harmonicOscOp_apply_eq_differential
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.harmonicOscOp_apply_eq_differential (n : ℕ) :
    harmonicOscOp ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = (memLp_harmonicDifferential n).toLp _ := by sorry
