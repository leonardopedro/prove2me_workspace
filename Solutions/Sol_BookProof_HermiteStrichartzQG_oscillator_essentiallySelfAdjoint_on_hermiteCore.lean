-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.oscillator_essentiallySelfAdjoint_on_hermiteCore
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_essentiallySelfAdjoint
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp oscillatorSymbol) := hermiteCoreOp_essentiallySelfAdjoint _
